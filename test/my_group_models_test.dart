import 'package:flutter_test/flutter_test.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_group_attention.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_group_list.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_group_invitations.dart';

// Trimmed copies of real staging responses.
void main() {
  test('parses /my-managed', () {
    final r = myGroupListResponseFromJson('''
{"success": true, "data": {"items": [{"id": 5, "name": "Chess Masters Club",
  "image": {"url": "https://x/a.jpg"}, "interest": {"name": "Chess"},
  "privacy": {"code": 2, "label": "Private · Admin approval"}, "town": {"id": 46820, "name": "Issaquah"},
  "radius_miles": 5, "member_count": 2, "post_count": 1, "upcoming_activity_count": 0,
  "unread_post_count": null, "role": "owner"}],
  "pagination": {"current_page": 1, "per_page": 12, "total": 3, "last_page": 1}}}''');
    final g = r.data!.items!.single;
    expect(g.name, 'Chess Masters Club');
    expect(g.privacy?.code, 2);
    expect(g.town?.name, 'Issaquah');
    expect(g.memberCount, 2);
    expect(g.role, 'owner');
    expect(r.data!.pagination?.lastPage, 1);
  });

  test('parses /my-invitations', () {
    final r = myGroupInvitationsResponseFromJson('''
{"success": true, "data": {"items": [{"id": "group:6", "invitation_id": 4, "requires_email_link": false,
  "type": "group", "group_id": 6, "name": "Issaquah Basketball Club",
  "description": "Connect with local people interested in basketball.",
  "image_url": "https:\/\/x\/hero.webp", "status": 0, "invited_at": "2026-10-28 11:53:32"}]}}''');
    final i = r.items!.single;
    expect(i.invitationId, 4);
    expect(i.groupId, 6);
    expect(i.imageUrl, 'https://x/hero.webp');
    expect(DateTime.tryParse(i.invitedAt!), isNotNull);
  });

  test('parses /my-attention and tolerates a null count', () {
    final r = myGroupAttentionResponseFromJson('''
{"success": true, "data": {"counts": {"membership": 1, "activity": null}, "total": 1,
  "items": [{"id": 2, "type": "membership", "name": "max martin", "subject": "Chess Masters Club",
    "status": "awaiting_response", "group_id": 5, "created_at": "2026-10-27T13:13:46+00:00",
    "history": [{"action": "asked", "user_id": 877, "created_at": "2026-10-27T13:14:31+00:00",
      "questions": [{"answer": "", "question": "Why you want to join this group?", "question_id": "0-0"}]}]}],
  "pagination": {"page": 1, "has_more": false}}}''');
    final d = r.data!;
    expect(d.counts, {'membership': 1, 'activity': 0});
    final item = d.items!.single;
    expect(item.type, 'membership');
    expect(item.history!.single.questions!.single.question, 'Why you want to join this group?');
    expect(d.pagination?.hasMore, false);
  });
}
